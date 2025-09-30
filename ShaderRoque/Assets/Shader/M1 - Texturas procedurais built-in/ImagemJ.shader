Shader "Custom/ImagemJ"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Radius ("Radius", Range(0,1)) = 0.5
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
        float _Radius;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float2 center = float2(0.5, 0.5);

            // Calcula a distância do pixel atual (IN.uv_MainTex) até o centro
            float dist_from_center = distance(IN.uv_MainTex, center);

            // Se a distância for menor que o raio, pinta com a cor, senão pinta de branco
            if (dist_from_center < _Radius)
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
