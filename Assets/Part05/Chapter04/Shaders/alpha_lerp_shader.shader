Shader "Custom/Part5/Chapter4/AlphaLerpShader"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2 ("Albedo (RGB)", 2D) = "white" {}
        _LerpValue ("Lerp Value", Range(0, 1)) = 0.5
        [Enum (Local Space, 0.5, World Space, 1.5)] _Space ("Space", Float) = 0
        [KeywordEnum (Red, Green, Blue)] _Color ("Color", Int) = 0
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard

        sampler2D _MainTex;
        sampler2D _MainTex2;
        float _LerpValue;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2;
        };

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c1 = tex2D(_MainTex, IN.uv_MainTex);
            fixed4 c2 = tex2D(_MainTex2, IN.uv_MainTex2);

            // Alpha Lerp 1
            // o.Albedo = c2 * c1.a + c1 * (1 - c1.a);
            // o.Albedo = lerp(c1, c2, c1.a);

            // Alpha Lerp 2
            // o.Albedo = c1 * c1.a + c2 * (1 - c1.a);
            o.Albedo = lerp(c1, c2, 1 - c1.a);
            o.Alpha = 0;
        }
        ENDCG
    }
    FallBack "Diffuse"
}