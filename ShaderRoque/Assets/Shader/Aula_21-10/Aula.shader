Shader "Unlit/Aula"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _A("Slider 1", Range(0, 360)) = 1
        _B("Slider 2", Range(0, 360)) = 1
        [HDR] _Color("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _A,_B,_Color;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                

                //Matiz Identidade *1
                //float2x2 matriz = float2x2
                // (
                //     1, 0,
                //     0, 1
                // );

                //Matriz Scale(a,0,0,b)
                //float2x2 matriz = float2x2
                // (
                //     _A, 0,
                //     0, _B
                // );

                //Matriz Cisalhamento(1,a,b,1)
                // float2x2 matriz = float2x2
                // (
                //     1, sin(_Time.y) * _A,
                //     _B, 1
                // );

                // float2 uv= mul(matriz, i.uv);
                // float4 col = tex2D(_MainTex, uv);
                // return col;

                //Matriz Rotação(Cos, -sin, sin, cos)
                // _A = _A * 3.14 /180;
                // _A = radians(_A);
                // float2x2 matriz = float2x2
                // (
                //    cos(_A), -sin(_A),
                //     sin(_A), cos(_A)
                // );
                // float2 p = float2(0.5, 0.5); 

                //Matriz de translação ()
                float3x3 matriz = float3x3
                (
                  1,0,_A,
                  0,1,_B,
                  0,0,1
                );

                float3x3 matriz2 = float3x3
                (
                    cos(_Time.y), -sin(_Time.y), 0,
                    sin(_Time.y), cos(_Time.y), 0,
                    0,0,1
                );
                float3x3 matriz3 = float3x3
                (
                  1,0,-_A,
                  0,1,-_B,
                  0,0,1
                );
                
                float3x3 m = mul(mul(matriz, matriz3), matriz2);
                float3 uv = mul(matriz,float3(i.uv, 1));
                float4 col = tex2D(_MainTex, uv.xy);
                return col;
            }
            ENDCG
        }
    }
}
