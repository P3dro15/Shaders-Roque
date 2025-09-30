Shader "Custom/Aula2"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _GradienteTex ("Gradiente (RGB)", 2D) = "white" {}
        _Slider ("Slider", Range(-10, 10)) = 2.5
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Luz

        sampler2D _MainTex, _GradienteTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 _Color;
        float _Slider;

        void surf (Input IN, inout SurfaceOutput o)
        {
           // fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
           // o.Albedo = 0;
        }

        float4 LightingLuz(SurfaceOutput s, float3 lightDir, float atten)
        {
            float3 amb = s.Albedo;
            float diff = max(0, dot(lightDir, s.Normal));
            float4 c = tex2D(_GradienteTex, float2(diff, 0.1));
            //float3 spec
            return c; //diff * _LightColor0 * atten * float4(s.Albedo, 1);
        }

        ENDCG
    }
    FallBack "Diffuse"
}
