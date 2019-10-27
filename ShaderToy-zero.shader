Shader "Unlit/ShaderToy-zero"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_Rotate("Rotate_Value",Range(0,360))=0
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }
        LOD 100

        Pass
        {
		    ZWrite On
			Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

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
            };

            sampler2D _MainTex;
			float4		  _MainTex_ST;
			float			  _Rotate;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
               // o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
			//for cal rotate
				float r=radians(_Rotate);
				float x=i.uv.x-0.5;
				float y=i.uv.y-0.5;

				float a=cos(r);
				float b=-sin(r);
				float c=sin(r);
				float d=cos(r);

				float nx=a*x+b*y+0.5;
				float ny=c*x+d*y+0.5;
			
				float4 tex=tex2D(_MainTex,float2(nx,ny));
			//for Gradient  color
				float3 col = 0.5+0.5*cos(_Time.y+i.uv.xyx+float3(0,2,4));
				tex=tex*float4(col,1);
				 // apply fog
                UNITY_APPLY_FOG(i.fogCoord, tex);

                return tex;
            }

            ENDCG
        }
    }
}
