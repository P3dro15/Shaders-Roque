Shader "Custom/ImagemK"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
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
        float _A, _B;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float2 uv = IN.uv_MainTex;
            //Cria um padrão de faixas verticais alternadas, usando uma onda senoidal arredondada.
            float k = round(saturate(sin(_A * uv.x)));
            o.Albedo = k + _Color; 
        }
        ENDCG
    }
    FallBack "Diffuse"
}
