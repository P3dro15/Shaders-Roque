Shader "Custom/Teste" {
    Properties {
        _MainTex ("Texture", 2D) = "white"{}
        _A ("A", Range(0, 11)) = 5
        _B ("B", Range(-10, 0)) = 0
        _C ("C", Range(-1, 1)) = 0.5
        _D ("D", Range(0, 10)) = 0.5
        _Color1 ("Cor 1", Color) = (0, 0, 1, 1)
        _Color2 ("Cor 2", Color) = (0, 0, 1, 1)
    }
    SubShader {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        sampler2D _MainTex;
        struct Input { float2 uv_MainTex;};
        float _A, _B, _C, _D;
        float4 _Color1, _Color2;
        void surf (Input IN, inout SurfaceOutputStandard o) {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex * 2 - float2(0.5, 0.5));
            float2 uv = IN.uv_MainTex;
            float left = saturate(round(-10 * uv.x + _A));
            float right = saturate(round(10 * uv.x + _B));
            float middle = 1-(left + right);
            o.Albedo = left * _Color1 + right * _Color2 + middle * c;
        }
        ENDCG
    }
}


