Shader "Unlit/30_09"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Color", Color) = (1, 1, 1, 1)
        _Slider("_Slider", Range(0, 10)) = 0
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque"  "RenderPipeline" = "UniversalPipeline"}

        Pass
        {
            Tags{"LightMode" = "UniversalFoward"}
            Cull Front
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"


            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            CBUFFER_START(UnityPerMaterial)
                sampler2D _MainTex;
                float4 _MainTex_ST;
                float4 _Color;
                float _Slider;
            CBUFFER_END

            v2f vert (appdata v)
            {
                v2f o;
                v.vertex.xyz += v.normal * _Slider;
                o.vertex = TransformObjectToHClip(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                return _Color;
            }
            ENDHLSL
        }

        // Pass
        // {
        //     Tags{"LightMode" = "UniversalFoward"}
        //     Cull Back
        //     HLSLPROGRAM
        //     #pragma vertex vert
        //     #pragma fragment frag


        //     #include "UnityCG.cginc"
        //     #include "Assets/Template/Noise.cginc"
        //     #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

        //     struct appdata
        //     {
        //         float4 vertex : POSITION;
        //         float2 uv : TEXCOORD0;
        //         //float3 normal : NORMAL;
        //     };

        //     struct v2f
        //     {
        //         float2 uv : TEXCOORD0;
        //         float4 vertex : SV_POSITION;
        //     };

        //     sampler2D _MainTex;
        //     float4 _MainTex_ST;

        //     v2f vert (appdata v)
        //     {
        //         v2f o;
        //         o.vertex = UnityObjectToClipPos(v.vertex);
        //         o.uv = TRANSFORM_TEX(v.uv, _MainTex);
        //         return o;
        //     }

        //     fixed4 frag (v2f i) : SV_Target
        //     {
        //         fixed4 col = tex2D(_MainTex, i.uv);
        //         float o = 0;
        //         Unity_SimpleNoise_float(i.uv, 100, o);
        //         return o;
        //     }
        //     ENDHLSL
        // }
    }
}
