Shader "Custom/ImagemA"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _A ("A", Range(-10,20)) = 5
        _B ("B", Range(-10,20)) = 0
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

            //A expressão linear é usanda para criar um gradiente
            o.Albedo = _A * uv.x + _B;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
