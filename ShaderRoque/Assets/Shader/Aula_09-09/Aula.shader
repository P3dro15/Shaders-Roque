Shader "Custom/Aula"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _ORMTex ("ORM (RGB)", 2D) = "white" {}
        _NormalTex("Normal", 2D) = "white" {}
        _EmissionTex ("Emission", 2D) = "white" {}
        _AlphaTex("Alpha", 2D) = "white" {}
        _Slider ("Slider", Range(-10,10)) = 0
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows alpha : blend

        
        struct Input
        {
            float2 uv_MainTex;
            float2 uv_ORMTex;
            float2 uv_Emission;
            float2 uv_Alpha;
            float2 uv_Normal;
        };
        
        sampler2D _MainTex, _NormalTex, _ORMTex, _EmissionTex, _AlphaTex;
        float _Slider;
        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            //fixed4 c = tex2Dlod (_MainTex,float4 (IN.uv_MainTex, 0, _Slider));
            float4 c = tex2D (_MainTex, IN.uv_MainTex);
            float4 orm = tex2D (_ORMTex, IN.uv_ORMTex);
            float3 normal = UnpackNormal(tex2D(_NormalTex, IN.uv_Normal));
            float4 Emission = tex2D (_EmissionTex, IN.uv_Emission);
            normal.xy *= _Slider;

            o.Albedo = c.r;
            o.Normal = normal.rgb;
            o.Metallic = orm.b;
            //o.Smoothness = orm.g;
            o.Occlusion = orm.r;
            //o.Emission = e.r;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
