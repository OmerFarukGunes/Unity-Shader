Shader "Custom/25_CutOff"
{
    Properties
    {
       _RimColor("Rim Color", Color) = (0,0.5,0.5,0) //Red
       _RimPower("Rim Power", Range(0.5,8.0)) = 3.0
    }
        SubShader
    {

        CGPROGRAM
        #pragma surface surf Lambert

       struct Input
        {
            float3 viewDir;
            float3 worldPos;
        };
         float4 _RimColor;
         float _RimPower;
        void surf(Input IN, inout SurfaceOutput o)
        {
            half rim = /*1- yapmazsane beyaztan alır*/1 - saturate(dot(normalize(IN.viewDir), o.Normal));
           //kırmızıdan yeşile içe doğru gidersin o.Emission =rim > 0.5 ? float3(1,0,0) : rim > 0.3 ? float3(0, 1, 0):0; //pow = power etkiyi arttırır
            o.Emission = frac(IN.worldPos.y * 5 * 0.5) > 0.4 
                ? float3(0, 1, 0)*rim : float3(1, 0, 0)*rim;
        }
        ENDCG
    }
        FallBack "Diffuse"
}