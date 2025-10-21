Shader "Custom/Tarefa"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0

        _Frequency ("Frequency", Range(1, 50)) = 15
        _Strength ("Strength", Range(0, 1)) = 1.0
        _Speed ("Speed", Range(0, 5)) = 1.0
        _Opacity("Opacity", Range(0,1)) = 0.5
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows alpha

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        half _Frequency;
        half _Strength;
        half _Opacity;
        half _Speed;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            half borda = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));  

            fixed3 portalColor = sin(borda * _Frequency + (_Time.y * _Speed) + fixed3(0.0, 0.5, 1.0) ) * 0.5 + 0.5;

            o.Albedo = _Color.rgb + portalColor * _Strength;
            
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;

            o.Alpha = borda * _Opacity;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
