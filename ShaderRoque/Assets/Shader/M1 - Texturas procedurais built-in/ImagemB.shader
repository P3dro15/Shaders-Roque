Shader "Custom/ImagemB"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
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

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float u = IN.uv_MainTex.x;
            float v = IN.uv_MainTex.y;

            // Calcula um valor que é 0 na diagonal vermelha e 1 na diagonal azul
            float blueAmount = abs(u - v);

            // O vermelho é o inverso do azul
            float redAmount = 1.0 - blueAmount;

            fixed3 finalColor = float3(redAmount, 0, blueAmount);

            o.Albedo = finalColor;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
