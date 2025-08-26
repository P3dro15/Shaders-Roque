Shader "Custom/ImagemC"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _A ("A", Range(0,10)) = 5
        _B ("B", Range(0,10)) = 5
        _C ("C", Range(0,10)) = 5
        _D ("D", Range(0,10)) = 5   
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 _Color;
        float _A, _B, _C, _D;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float2 uv = IN.uv_MainTex;
            float c = _A * uv.x + _B;
            c = (c * c) * -1 + _C;
            o.Albedo = half3(c,0,0) + _Color;

            // float uv = IN.uv_MainTex.x;
            // float f = _A * uv + _B;
            // float g = _C * (f) + _D;
            // o.Albedo = g + _Color;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
