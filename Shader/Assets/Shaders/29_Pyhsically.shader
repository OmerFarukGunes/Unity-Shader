Shader "Custom/29_Geometry"
{

	SubShader
	{
		Tags
		{
			"Queue" = "Geometry"
		}
		CGPROGRAM
		#pragma surface surf Standard

	   struct Input
		{
			float2 uv_MetallicTex;
		};
		  sampler2D _MetallicTex;
		  half _Metallic;
		  fixed4 _Color;
		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			o.Albedo = _Color.rgb;
			o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex).r;
			o.Metallic = _Metallic;
		 }
		 ENDCG
	}
		FallBack "Diffuse"
}