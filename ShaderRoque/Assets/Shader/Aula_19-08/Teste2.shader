Shader "Custom/Teste2"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _Color2("Color 2", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _A ("A", Range(-20,20)) = 5
        _B ("B", Range(-20,20)) = 1
        _C ("C", Range(-20,20)) = 1
        _D ("D", Range(-20,20)) = -0.5
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

        float4 _Color, _Color2;
        float _A, _B, _C, _D;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float2 uv2 = IN.uv_MainTex;
            float4 tex = tex2D(_MainTex, IN.uv_MainTex);
            float f = saturate(round(_A * uv2.x + _B));
            float g = saturate(round(_C * uv2.x + _D));
            float m = 1 - (f + g);
            o.Albedo = f * _Color + g * _Color2 + m * tex;
            //o.Albedo = 1 - (f + g);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
