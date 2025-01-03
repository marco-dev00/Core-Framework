Texture2D<float4> img : register(t1);
sampler imgSampler : register(s1);

cbuffer PS_VARIABLES : register(b0) {
	// IMPORTANT: the parameters must be in the same order as in your XML file
float fFreq;
float fPeriods;
float fAmplitude;
};

struct PS_INPUT
{
  float4 Tint : COLOR0;
  float2 texCoord : TEXCOORD0;
  float4 Position : SV_POSITION;
};

//Main Shader Function
float4 ps_main( in PS_INPUT In ) : SV_TARGET {

float2 uv = float2(In.texCoord.x + (sin((In.texCoord.y + fFreq) * fPeriods) * fAmplitude), In.texCoord.y);

float4 color = img.Sample(imgSampler, uv)* In.Tint;

    return color;

}