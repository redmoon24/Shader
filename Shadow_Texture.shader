Shader "Unlit/Shadow_Texture"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_TestFloat("TestFloat",Range(0,0.1))=0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

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
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4		  _MainTex_ST;
			float			  _TestFloat;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
				float4 col;
                col.r = tex2D(_MainTex, i.uv-float2(_TestFloat,0)).r;
                col.g = tex2D(_MainTex, i.uv).g;
                col.b= tex2D(_MainTex, i.uv+float2(_TestFloat,0)).b;
                col.a= 1;
                return col;
            }
            ENDCG
        }
    }
}
