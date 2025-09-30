Shader "Custom/Vertex2"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Slider ("Slider", Range(0,5)) = 0.5
        //_Vec4 ("Vector", Vector) = [0,0,0,0]
    }
    SubShader
    {
        Cull Off
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows vertex:vert

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float4 color: COLOR;
        };

        half _Slider;
        fixed4 _Color;
        float4 _Vec4;

        void vert(inout appdata_full v, out Input o)
        {
            //UNITY_INITIALIZE_OUTOUT(Input o);
            o.color = v.color;
            o.uv_MainTex = v.texcoord.xy;
        }

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = IN.color;
        }
        ENDCG
    }
    FallBack "Diffuse"
}