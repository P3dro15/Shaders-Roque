Shader "Custom/ImagemF"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Radius ("Radius", Range(0,10)) = 2
        _A ("A", Range(-10,20)) = 5
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
        float _Radius, _A;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            //Calcula a posição do pixel em relação ao centro da esfera
            float2 center = IN.uv_MainTex - float2(0.5, 0.5);
            //Calcula a distância do pixel até o centro da esfera
            float dist = distance(center, float2(0, 0));
            //Define a intensidade do brilho: quanto mais longe do centro, menor a intensidade
            float intensity = 1 - (dist * _Radius);
            //Garante que a intensidade fique entre 0 e 1
            intensity = saturate(intensity);
            //Cria uma cor em escala de cinza baseada na intensidade calculada
            float3 finalColor = float3(intensity, intensity, intensity) * _A;
            o.Albedo = finalColor;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
