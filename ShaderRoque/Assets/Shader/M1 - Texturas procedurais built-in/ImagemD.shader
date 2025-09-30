Shader "Custom/ImagemD"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _A ("Line Count", Float) = 10
        _B ("Line Width", Range(0.01, 1.0)) = 0.5
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
        float _A, _B;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            //Soma U e V para criar um gradiente diagonal.
            float diagonal_value = 1 - IN.uv_MainTex.x + IN.uv_MainTex.y;

            //Multiplica pelo número de linhas e usa frac() para repetir o padrão.
            float wave = frac(diagonal_value * _A);

            //Usa step() para criar uma transição nítida.
            float finalColor = step(_B, wave);

            o.Albedo = finalColor;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
