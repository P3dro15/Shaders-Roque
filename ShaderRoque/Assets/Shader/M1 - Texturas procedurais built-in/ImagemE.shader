Shader "Custom/ImagemE"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Radius ("Radius", Range(0,10)) = 2
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
        float _Radius, _A;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            //1
            //Calcula a posição do pixel em relação ao centro da esfera.
            float2 sphere = IN.uv_MainTex - float2(0, 0.95);
            //Calcula a distância do pixel até o centro da esfera.
            float dist = distance(sphere, float2(0, 0));
            //Define a intensidade do brilho quanto mais longe do centro, menor a intensidade.
            float intensity = 1 - (dist * _Radius);
            //Garante que a intensidade fique entre 0 e 1.
            intensity = saturate(intensity);
            //Cria uma cor em escala de cinza baseada na intensidade calculada.
            float3 finalColor1 = float3(intensity, intensity, intensity);
            
            //2
            float2 sphere2 = IN.uv_MainTex - float2(0, 0.5);
            float dist2 = distance(sphere2, float2(0, 0));
            float intensity2 = 1 - (dist2 * _Radius);
            intensity2 = saturate(intensity2);
            float3 finalColor2 = float3(intensity2, intensity2, intensity2);
            
            //3
            float2 sphere3 = IN.uv_MainTex - float2(0, 0.03);
            float dist3 = distance(sphere3, float2(0, 0));
            float intensity3 = 1 - (dist3 * _Radius);
            intensity3 = saturate(intensity3);
            float3 finalColor3 = float3(intensity3, intensity3, intensity3);
            
            //4
            float2 sphere4 = IN.uv_MainTex - float2(0.5, 0.95);
            float dist4 = distance(sphere4, float2(0, 0));
            float intensity4 = 1 - (dist4 * _Radius);
            intensity4 = saturate(intensity4);
            float3 finalColor4 = float3(intensity4, intensity4, intensity4);
            
            //5
            float2 sphere5 = IN.uv_MainTex - float2(0.5, 0.5);
            float dist5 = distance(sphere5, float2(0, 0));
            float intensity5 = 1 - (dist5 * _Radius);
            intensity5 = saturate(intensity5);
            float3 finalColor5 = float3(intensity5, intensity5, intensity5);
            
            //6
            float2 sphere6 = IN.uv_MainTex - float2(0.5, 0.03);
            float dist6 = distance(sphere6, float2(0, 0));
            float intensity6 = 1 - (dist6 * _Radius);
            intensity6 = saturate(intensity6);
            float3 finalColor6 = float3(intensity6, intensity6, intensity6);
            
            //7
            float2 sphere7 = IN.uv_MainTex - float2(1, 0.95);
            float dist7 = distance(sphere7, float2(0, 0));
            float intensity7 = 1 - (dist7 * _Radius);
            intensity7 = saturate(intensity7);
            float3 finalColor7 = float3(intensity7, intensity7, intensity7);
            
            //8
            float2 sphere8 = IN.uv_MainTex - float2(1, 0.5  );
            float dist8 = distance(sphere8, float2(0, 0));
            float intensity8 = 1 - (dist8 * _Radius);
            intensity8 = saturate(intensity8);
            float3 finalColor8 = float3(intensity8, intensity8, intensity8);
            
            //9
            float2 sphere9 = IN.uv_MainTex - float2(1, 0.03);
            float dist9 = distance(sphere9, float2(0, 0));
            float intensity9 = 1 - (dist9 * _Radius);
            intensity9 = saturate(intensity9);
            float3 finalColor9 = float3(intensity9, intensity9, intensity9);

            o.Albedo = finalColor1 + finalColor2 + finalColor3 + finalColor4 + finalColor5 + finalColor6 + finalColor7 + finalColor8 + finalColor9;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
