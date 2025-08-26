Shader "Custom/ImagemH"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _ColorB ("Color B", Color) = (0,0,0,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _A ("A", Range(0,10)) = 5
        _B ("B", Range(0,10)) = 5
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

        fixed4 _Color, _ColorB;
        float _A, _B;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float u = IN.uv_MainTex.x;
            float v = IN.uv_MainTex.y;

            float3 finalColor;

            // Checa se o pixel está no quadrante inferior-esquerdo OU no superior-direito
            if ((u < 0.5 && v < 0.5) || (u >= 0.5 && v >= 0.5))
            {
                finalColor = _Color.rgb;
            }
            else
            {
                // Se não, o pixel está nos outros dois quadrantes. Pinta com a Cor B.
                finalColor = _ColorB.rgb;
            }

            o.Albedo = finalColor;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
