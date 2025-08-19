Shader "Custom/CGTeste"
{
    Properties
    {
        _Color1 ("Color 1", Color) = (1,1,1,1)
        _Color2 ("Color 2", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}

        _Slider ("Slider", Range(0, 1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };
        float4 _Color1, _Color2;
        float _Slider;
        

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // float2 p = IN.uv_MainTex + float2(_Time.z, _Time.y) * _Slider;
            // float4 d = tex2D (_MainTex, p);
            
            // float4 c = tex2D (_MainTex, IN.uv_MainTex);
            // o.Albedo = float3(IN.uv_MainTex, 0);
            // if(IN.uv_MainTex.y > 0.5 && IN.uv_MainTex.y < 1){
            //     o.Albedo = IN.uv_MainTex.x   + IN.uv_MainTex.y * c + d;
            // }
            // else{
            //     o.Albedo = 1 - c + d;
            // }

            float x = IN.uv_MainTex.x;
            float y = IN.uv_MainTex.y; 
            float4 c1 = x * _Color1;
            float4 c2 = (1 - x) * _Color2 * _Slider;
            o.Albedo = c1 + c2;

            
        }
        ENDCG
    }
    FallBack "Diffuse"
}
