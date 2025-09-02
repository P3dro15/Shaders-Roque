Shader "Custom/Code4"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _NoiseTex("Noise (RGB)", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _Color2 ("Color", Color) = (1,1,1,1)
        _Slider ("mix", Range(0, 10)) = 5
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows alpha : blend

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_NoiseTex;
            float3 viewDir;
            float3 worldPos;
            float3 worldRefl;
            float3 worldNormal;
            float4 screenPos;
            float4 color: COLOR;
        };

        sampler2D _MainTex, _NoiseTex;
        fixed4 _Color, _Color2;
        float _Slider;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            float4 noise = tex2D(_NoiseTex, IN.uv_NoiseTex);
            float fresnel = step(noise * _Slider, dot(o.Normal, IN.viewDir));
            //o.Albedo = step(_Slider, dot(o.Normal, IN.viewDir));
            o.Albedo = 1-(1 - fresnel)* noise + fresnel * c;
            o.Alpha = 1; //1 - dot(o.Normal, IN.viewDir);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
