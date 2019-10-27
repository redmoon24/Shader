	Shader "Unlit/VFace"
	{
		Properties
		{
			_FrontTex ("FrontTex", 2D) = "white" {}
			_BackTex("BackTex", 2D) = "white" {}
		}
		SubShader
		{
			Tags { "RenderType"="Opaque" }
			LOD 100
			cull off

			Pass
			{
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma target 3.0
		
				#include "UnityCG.cginc"

				sampler2D _FrontTex;
				sampler2D _BackTex;

				struct appdata
				{
					float4 vert : POSITION;
					float2 uv : TEXCOORD0;
				};

				struct v2f
				{
					float2 uv : TEXCOORD0;
					float4 pos : SV_POSITION;
				};

				v2f vert (appdata v)
				{
					v2f o;
					o.pos = UnityObjectToClipPos(v.vert);
				    o.uv=v.uv;
					return o;
				}

				fixed4 frag (v2f i,float face:VFACE) : SV_Target
				{
					fixed4 col=1;
					col = face>0 ? tex2D(_FrontTex,i.uv) : tex2D(_BackTex,i.uv);
					return col;
				}
				ENDCG
			}
		}
	}
