Shader "Custom/19_08"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _A ("A", Range(-10,20)) = 5
        _B ("B", Range(-10,20)) = 0
        _C ("C", Range(-10,20)) = 0.5
        _D ("D", Range(-10,20)) = 0.5
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

        float _A, _B, _C, _D;  

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float2 uv = IN.uv_MainTex;
            o.Albedo = round(sin(_A * uv.x + _B) * _C + _D);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
