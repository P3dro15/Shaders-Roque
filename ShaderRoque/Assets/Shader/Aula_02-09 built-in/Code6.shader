Shader "Custom/Code6"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _CubeTex("Cube (RGB)", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _Color2 ("Color", Color) = (1,1,1,1)
        _Slider ("mix", Range(0, 100)) = 50
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows alpha : blend

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_CubeTex;
            float3 viewDir;
            float3 worldPos;
            float3 worldRefl;
            float3 worldNormal;
            float4 screenPos;
            float4 color: COLOR;
        };

        samplerCUBE _CubeTex;
        sampler2D _MainTex;
        fixed4 _Color, _Color2;
        float _Slider;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float4 c = texCUBE (_CubeTex, IN.worldRefl);
            o.Albedo = c;
            o.Alpha = 1;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
