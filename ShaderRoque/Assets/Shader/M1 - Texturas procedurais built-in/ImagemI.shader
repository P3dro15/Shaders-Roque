Shader "Custom/ImagemI"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Radius ("Radius", Range(0,1)) = 0.5
        _A ("A", Range(-10,10)) = 5
        _B ("B", Range(-10,10)) = 5
        _C ("C", Range(-10,10)) = 5
        _D ("D", Range(-10,10)) = 5
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
        float _Radius, _A, _B, _C, _D;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Desenha um quadrado na tela de tamanho (_A, _B) e posição (_C, _D)
            if((IN.uv_MainTex.x > _A && IN.uv_MainTex.y < _B) && (IN.uv_MainTex.x < _C && IN.uv_MainTex.y > _D))
            {
                o.Albedo = _Color.rgb;
            }
            else
            {
                o.Albedo = float3(1,1,1);
            }
        }
        ENDCG
    }
    FallBack "Diffuse"
}
