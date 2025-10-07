Shader "Custom/AnimatedPBR_QuantizedLight"
{
    Properties
    {
        _Color ("Base Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Tex2 ("Secondary Texture", 2D) = "white" {}
        _Slider("Light Slider", Range(1, 1.8)) = 0.0
        _Metallic ("Metallic", Range(0,1)) = 0.5
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows vertex:vert

        sampler2D _MainTex;
        sampler2D _Tex2;
        half _Slider;
        fixed4 _Color;
        half _Metallic;
        half _Glossiness;

        struct Input
        {
            float2 uv_MainTex;
            float3 worldPos;
            float3 viewDir;
        };

        void vert(inout appdata_full v)
        {
            // Deformação procedural dos vértices
            float wave = sin(10 * v.texcoord.y + _Time.y) * 0.2;
            v.vertex.xyz += v.normal * wave;
        }

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            // Cor base multiplicada pela cor
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;

            // Luz direcional aproximada para quantização
            float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
            float diff = max(0, dot(o.Normal, lightDir));

            // Quantização da luz
            diff = round(diff * _Slider) / _Slider;

            // Multiplica pela segunda textura
            fixed4 tex2Col = tex2D(_Tex2, float2(diff, 0.1));
            o.Albedo = c.rgb * tex2Col.rgb;

            // PBR
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }

    FallBack "Diffuse"
}
