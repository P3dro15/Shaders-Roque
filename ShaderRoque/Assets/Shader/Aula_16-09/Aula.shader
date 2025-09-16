Shader "Custom/Aula"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Slider ("Smoothness", Range(0,10000)) = 0
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Luz

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 _Color;
        float _Slider;

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rbg;
        }

        float4 LightingLuz(SurfaceOutput s, float3 lightDir, float atten)
        {
            float3 amb = s.Albedo;
            float diff = max(0, dot(lightDir, s.Normal));
            diff = round(diff * _Slider) / _Slider;
            //float3 spec
            return diff * float4(s.Albedo, s.Alpha) ;//* _LightColor0 * atten * float4(s.Albedo, 1);//_LightColor0 * atten;
        }

        ENDCG
    }
    FallBack "Diffuse"
}
