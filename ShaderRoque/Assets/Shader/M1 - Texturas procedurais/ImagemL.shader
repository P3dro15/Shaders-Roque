Shader "Custom/ConcentricRings"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _RingCount ("Ring Count", Range(1, 50)) = 10
        _LineWidth ("Line Width", Range(0.01, 1.0)) = 0.5
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
        
        float _RingCount, _LineWidth;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            //Calcula a distância do pixel atual até o centro (0.5, 0.5)
            float dist_from_center = distance(IN.uv_MainTex, float2(0.5, 0.5));

            //Multiplicamos a distância pela contagem de anéis.
            //frac() faz o valor ir de 0 a 1 repetidamente, criando os anéis.
            float wave = frac(dist_from_center * _RingCount);

            //step() retorna 0 se a onda for menor que a largura da linha, e 1 se for maior.
            //Isso cria o padrão de anéis pretos e brancos.
            float ring_mask = step(_LineWidth, wave);

            fixed3 finalColor = fixed3(ring_mask, ring_mask, ring_mask);

            o.Albedo = 1 - finalColor;
        }
        ENDCG
    }
    FallBack "Diffuse"
}