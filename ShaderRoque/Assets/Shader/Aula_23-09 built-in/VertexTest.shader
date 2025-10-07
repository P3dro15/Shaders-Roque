 Shader "Custom/VertexTest"
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
        };

        half _Slider;
        fixed4 _Color;
        float4 _Vec4;

        void vert(inout appdata_full v)
        {
            float d = length(v.texcoord.xy - float2 (0.5, 0.5));
            float high = tex2Dlod(_MainTex, v.texcoord + float4(_Time.x, 0, 0, 0));
            //v.vertex.xyz = v.vertex.xyz + v.normal * abs(sin(1 * _Time.y));
            float onda = sin(20 * v.texcoord.y +  _Time.y) * _Slider;
            //v.vertex.xyz = v.vertex.xyz + v.normal * onda;
            v.vertex.xyz = v.vertex.xyz + v.normal * d * _Slider;

        }

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float d = length(IN.uv_MainTex - float2 (0.5, 0.5));
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex + float2(_Time.x, 0)) * _Color;
            o.Albedo = d;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
