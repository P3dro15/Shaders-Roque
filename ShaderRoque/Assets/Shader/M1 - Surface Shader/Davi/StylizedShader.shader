Shader "Custom/StylizedShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _LineColor ("Color", Color) = (0,0,0,1)
        _LineThickness("Line Thickness", Range(0,10)) = 2

        _HatichingPattern("Hatiching Pattern", 2D) = "whithe" {}
        [IntRange]_Step("Steps", Range(0,10)) = 2
        _StepSize("StepSize", Range(0.1,0.5)) = 0.5
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Toon fullforwardshadows
        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _HatichingPattern;
        fixed4 _HatichingPattern_ST;
        struct ToonSurfaceOutput{
            fixed3 Albedo;
            float2 uv_Cord;
            half3 Emission;
            fixed Alpha;
            fixed3 Normal;
            fixed3 Specular;

        };

        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
            float4 screenPos;
        };

        fixed _Step, _StepSize, _LineThickness, _SpecularFalloff, _SpecularSize;
        fixed4 _Specular;
        fixed4 _Color, _LineColor;
        fixed4 _HatichingColor;
        void surf (Input IN, inout ToonSurfaceOutput o)
        {
            fixed fresnel = saturate(round(dot(o.Normal, IN.viewDir) * _LineThickness));
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.uv_Cord = IN.uv_MainTex;
            o.uv_Cord = TRANSFORM_TEX(o.uv_Cord, _HatichingPattern);

            o.Specular = _Specular;
            o.Albedo = c.rgb * fresnel + (1 - fresnel) * _LineColor;
        }
        fixed4 LightingToon(ToonSurfaceOutput s, half3 lightDir, half atten, half3 viewDir)
        {
            fixed4 towardsLight = dot(s.Normal, lightDir);
            towardsLight = towardsLight/_StepSize;
            float lightIntensity = ceil(towardsLight);
            lightIntensity = saturate(lightIntensity/ _Step);

            fixed4 pattern = tex2D (_HatichingPattern, s.uv_Cord);
            fixed deepShadow = step(1,1 - lightIntensity);
            fixed shadow = step(0.75,1 - lightIntensity);
            fixed penumbra = step(0.5,1 - lightIntensity);
            penumbra = penumbra * pattern.r;
            shadow = shadow * pattern.g;
            deepShadow = deepShadow * pattern.b;
            fixed fullPatern = max(shadow, deepShadow);
            fullPatern = max(fullPatern, penumbra);

            lightIntensity = step(fullPatern, lightIntensity);

            fixed4 col;
            col.rgb = lightIntensity * s.Albedo * _LightColor0.rgb;
            col.a = s.Alpha;
            return col;
        }
        ENDCG
    }
    FallBack "Standard"
}
