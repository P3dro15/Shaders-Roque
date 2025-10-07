Shader "Custom/Code5"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _NoiseTex("Noise (RGB)", 2D) = "white" {}
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
            float2 uv_NoiseTex;
            float3 viewDir;
            float3 worldPos;
            float3 worldRefl;
            float3 worldNormal;
            float4 screenPos;
            float4 color: COLOR;
        };

        sampler2D _MainTex, _NoiseTex;
        fixed4 _Color, _Color2;
        float _Slider;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            float4 d = pow(IN.worldPos.z - _WorldSpaceCameraPos.z, 2) / _Slider;
            o.Albedo = d;
            o.Alpha = saturate(d);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
