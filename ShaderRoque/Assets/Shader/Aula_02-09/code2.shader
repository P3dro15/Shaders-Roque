Shader "Custom/Code2"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _Color2 ("Color", Color) = (1,1,1,1)
        _Slider ("mix", Range(0, 10)) = 5
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows alpha : blend

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
            float3 worldPos;
            float3 worldRefl;
            float3 worldNormal;
            float4 screenPos;
            float4 color: COLOR;
        };

        fixed4 _Color, _Color2;


        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.screenPos.xy) * _Color;
            //o.Albedo = c;
            o.Alpha = saturate(sin(IN.screenPos.r * 20));
            //o.Emission = saturate(c*(IN.screenPos.r * 20));
        }
        ENDCG
    }
    FallBack "Diffuse"
}
