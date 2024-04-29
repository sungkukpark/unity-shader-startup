Shader "Custom/Part4/Chapter4/RenderColor"
{
    Properties
    {
        // _Name ("Name", Range (min, max)) = number
        _Brightness ("Brightness", Range(0, 1)) = 0.5
        _TestFloat ("Test Float", Float) = 0.5
        _TestColor ("Test Color", Color) = (1,1,1,1)
        _TestVector ("Test Vector", Vector) = (0,0,0,0)
        _TestTexture ("Test Texture", 2D) = "white" {}

        // Built-in properties
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows noambient

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;

            // o.Albedo = float3(1, 0, 0);  // Red
            // o.Emission = float3(1, 0, 0) + float3(0, 1, 0); // Additive
            // o.Emission = float3(1, 0, 0) * float3(0, 1, 0); // Multiplicative
            // o.Emission = float3(1, 0, 0) + float3(1, 0, 0); // Red
            // o.Emission = float3(1, 0, 0) + float3(1, 0, 0) - 1; // Red
            o.Emission = float3(1, 0, 0) + float3(1, 0, 0) - 2; // Black

            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}