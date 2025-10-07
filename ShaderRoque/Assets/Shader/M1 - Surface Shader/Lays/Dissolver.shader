Shader "Custom/Dissolver"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _NoiseTex ("Noise (RGB)", 2D) = "white" {}
        _Color ("Base Color", Color) = (1, 1, 1, 1)
        _EdgeColor ("Edge Color", Color) = (1, 1, 1, 1)
        _DissolveAmount ("Dissolve Amount", Range(-0.6, 1)) = 0.0
        _EdgeWidth ("Edge Width", Range(0, 1)) = 0.05
    }


    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows alpha:blend

        sampler2D _MainTex;
        sampler2D _NoiseTex;
        float4 _Color;
        float4 _EdgeColor;
        float _DissolveAmount;
        float _EdgeWidth;


        struct Input { float2 uv_MainTex; float2 uv_NoiseTex; };


        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 baseCol = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            float noiseVal = tex2D(_NoiseTex, IN.uv_NoiseTex).r;

            // cálculo contínuo do dissolve
            float dissolve = noiseVal - _DissolveAmount;

            // borda do dissolve : highlight emissivo
            float edge = smoothstep(0, _EdgeWidth, dissolve);

            // quando dissolve < 0, pixel some
            if (dissolve < 0)
            {
                o.Alpha = 0;
                return;
            }

            // cor base
            o.Albedo = baseCol.rgb;
            o.Metallic = 0;
            o.Smoothness = 0.4;

            // emissão colorida nas bordas
            o.Emission = _EdgeColor.rgb * (1 - edge);

            o.Alpha = baseCol.a * edge;

        }
        ENDCG
    }
    FallBack "Transparent/Diffuse"
}