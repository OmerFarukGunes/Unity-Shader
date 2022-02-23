﻿Shader "Custom/39_BasicTextureBlend"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "White"{}
		_DecalTex("DecalTex", 2D) = "White"{}
		[Toggle] _ShowDecal("Show Decal?",Float) = 0
	}
	SubShader
	{
		Tags { "Queue" = "Geometry" }


		CGPROGRAM

		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _DecalTex;
		float _ShowDecal;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			fixed4 a = tex2D(_MainTex, IN.uv_MainTex);
			fixed4 b = tex2D(_DecalTex, IN.uv_MainTex) * _ShowDecal;
			//o.Albedo = a.rgb*b.rgb;
			//o.Albedo = a.rgb+b.rgb;
			o.Albedo = b.r > 0.9 ? b.rgb : a.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
