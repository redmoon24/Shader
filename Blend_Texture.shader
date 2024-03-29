﻿Shader "Unlit/Blend_Texture"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_SecondTex("Texture2",2D)="white"{}
		_Weight("Blend_Weight",Range(0,1))=0
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
            float4 _MainTex_ST;
			sampler2D _SecondTex;
            float4 _SecondTex_ST;
			float _Weight;

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
                fixed4 col = tex2D(_MainTex, i.uv);
				fixed4 col2=tex2D(_SecondTex,i.uv);
				float4 o=col*_Weight+ col2*(1-_Weight);
                return o;
            }
            ENDCG
        }
    }
}
