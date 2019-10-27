Shader "Unlit/Gray_Texture"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
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

			
			float4 GraySclae(float4 v)
			{
				float g=v.r*0.299+v.g*0.587+v.b*0.114;
				return float4(g,g,g,v.a);
			}


            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
				float4 col=tex2D(_MainTex,i.uv);
				col=GraySclae(col);

                return col;
            }
            ENDCG
        }
    }
}
