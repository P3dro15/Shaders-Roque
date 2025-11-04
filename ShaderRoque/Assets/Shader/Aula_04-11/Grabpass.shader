Shader "Unlit/Grabpass"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Slider ("Slide", Range (0,0.05)) = 0

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100
        GrabPass{"_Tex"}
        Pass
        { 
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag


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
                float4 cut : QUALQUERCOISA;
            };

            sampler2D _MainTex, _Tex;
            float4 _MainTex_ST;
            float _Slider;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.cut = ComputeGrabScreenPos(o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float4 col = tex2D(_MainTex, i.uv);
                i.cut.x += (sin(_Time.y * 5 + i.cut.y * 50) * _Slider);
                float4 color1 = tex2Dproj(_Tex, i.cut);
                //float4 color2 = tex2Dproj(_Tex, i.cut + float4(_Slider, 0,0,0));
                //return length(color1 - color2) > 0.01?0:1;
                return color1;
            }  
            ENDCG
        }
    }
}