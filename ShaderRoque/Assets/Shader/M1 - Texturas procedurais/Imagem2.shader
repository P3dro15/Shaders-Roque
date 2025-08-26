Shader "Custom/Imagem2"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _ColorA ("Color A", Color) = (0,0,0,1) // Preto por padrão
        _ColorB ("Color B", Color) = (0,1,0,1) // Verde por padrão
        _GridSize ("Grid Size", Range(2, 50)) = 8
        _Speed ("Animation Speed", Range(0.1, 10)) = 1.0
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

        fixed4 _ColorA, _ColorB;
        float _GridSize, _Speed;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Multiplica as UVs para definir o tamanho da grade
            float2 grid_uv = IN.uv_MainTex * _GridSize;
            
            // Usa floor() para obter o "índice" de cada célula
            // e fmod para criar um padrão alternado de 0 e 1
            float checker_x = floor(grid_uv.x);
            float checker_y = floor(grid_uv.y);
            float checker_mask = fmod(checker_x + checker_y, 2.0);

            // Multiplica o tempo pela velocidade e usa floor() para mudar de valor a cada segundo
            float time_switch = fmod(floor(_Time.y * _Speed), 2.0);

            //lterna entre 0 e 1, mudando o padrão xadrez a cada segundo.
            float final_mask = fmod(checker_mask + time_switch, 2.0);

            // Usa lerp para escolher entre a Cor A e a Cor B baseado na máscara final
            fixed3 finalColor = lerp(_ColorA.rgb, _ColorB.rgb, final_mask);

            o.Albedo = finalColor;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
