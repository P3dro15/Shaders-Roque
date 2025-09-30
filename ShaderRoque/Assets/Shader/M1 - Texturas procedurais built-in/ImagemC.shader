Shader "Custom/ImagemC"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _ColorBL ("Bottom Left", Color) = (0, 1, 1, 1)
        _ColorBR ("Bottom Right", Color) = (1, 1, 1, 1)
        _ColorTL ("Top Left", Color) = (1, 0, 1, 1)
        _ColorTR ("Top Right", Color) = (1, 1, 1, 1)
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

        float4 _ColorBL, _ColorBR, _ColorTL, _ColorTR;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float u = IN.uv_MainTex.x;
            float v = IN.uv_MainTex.y;

            // Mistura a cor do canto inferior esquerdo com a do inferior direito usando a coordenada u.
            float4 bottomColor = lerp(_ColorBL, _ColorBR, u);

            // Mistura a cor do canto superior esquerdo com a do superior direito usando a coordenada u.
            float4 topColor = lerp(_ColorTL, _ColorTR, u);

            // Mistura a cor da borda inferior com a da borda superior usando a coordenada v.
            float4 finalColor = lerp(bottomColor, topColor, v);

            o.Albedo = finalColor.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
