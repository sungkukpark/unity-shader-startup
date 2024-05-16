Shader "Custom/Part5/Chapter4/LerpShader"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2 ("Albedo (RGB)", 2D) = "white" {}
        _LerpValue ("Lerp Value", Range(0, 1)) = 0.5
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

            // o.Albedo = c.rgb;
            fixed4 c = lerp(c1, c2, _LerpValue).rgba;
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}