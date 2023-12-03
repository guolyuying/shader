// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/NewUnlitShader"
{
    Properties
    {
        [NoScaleOffset] _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            // vertex shader inputs
            struct appdata
            {
                float4 vertex : POSITION; // vertext position
                float2 uv : TEXCOORD0;  // texture coordinate
            };

            // vertex shader outputs (to fragment shader)
            struct v2f
            {
                float2 uv : TEXCOORD0; // texture coordinate
                float4 vertex : SV_POSITION; // clip space position
            };

            // vertex shader
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex); // transform from object space to clip space
                o.uv = v.uv; // just past texture coordinate
                return o;
            }

            sampler2D _MainTex; //connection variable (connect Properties written in Shaderlab and CGPROGRAM written in HLSL)

            // fragment shader; returns a fixed4 (low precision) color
            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture and return it
                fixed4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
}
