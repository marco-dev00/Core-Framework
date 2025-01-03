// Pixel shader input structure
struct PS_INPUT
{
  float4 Tint : COLOR0;
  float2 texCoord : TEXCOORD0;
  float4 Position : SV_POSITION;
};

Texture2D<float4> img : register(t0);
sampler imgSampler : register(s0);

Texture2D<float4> bg : register(t1);
sampler bgSampler : register(s1);

Texture2D<float4> Palettes : register(t2);
sampler PalettesSampler : register(s2);

cbuffer PS_VARIABLES:register(b0)
{
	int nPal, lerpA, lerpB;
	float lerpVal;
	float alpha;
}


float4 Demultiply(float4 _color)
{
	float4 color = _color;
	if ( color.a != 0 )
		color.xyz /= color.a;
	return color;
}

float4 ps_main(float4 color : COLOR0, in PS_INPUT In ) : SV_TARGET
{
	float mask =  img.Sample(imgSampler, In.texCoord).a;
	float4 output =  bg.Sample(bgSampler, In.texCoord);
	float colorIndex = -1;

	[unroll]for(int i=0;i<256 && mask > 0.0;i++)
	{
		float4 OriginalPalette = Palettes.Sample(PalettesSampler, float2(i/256.0,0.0));
		if(OriginalPalette.a = 0.0)
		{
			break;
		}
		else
		{
			if( distance(output.xyz, OriginalPalette.xyz) == 0 )
				{
					colorIndex = i/256.0;
					break;
				}
		}
	}

	if(colorIndex > -1)
	{
		float4 colorA = Palettes.Sample(PalettesSampler, float2(colorIndex, lerpA / float(nPal)));
		float4 colorB = Palettes.Sample(PalettesSampler, float2(colorIndex, lerpB / float(nPal)));
		output.xyz = lerp(colorA.xyz, colorB.xyz, lerpVal);
	}
	
	output.a = lerp(0.0, output.a, alpha);
	
	return output;
}


float4 ps_main_pm(float4 color : COLOR0, in PS_INPUT In ) : SV_TARGET
{
	float mask =  img.Sample(imgSampler, In.texCoord).a;
	float4 output =  bg.Sample(bgSampler, In.texCoord);
	float colorIndex = -1;

	[unroll]for(int i=0;i<256 && mask > 0.0;i++)
	{
		float4 OriginalPalette = Palettes.Sample(PalettesSampler, float2(i/256.0,0.0));
		if(OriginalPalette.a = 0.0)
		{
			break;
		}
		else
		{
			if( distance(output.xyz, OriginalPalette.xyz) == 0 )
				{
					colorIndex = i/256.0;
					break;
				}
		}
	}

	if(colorIndex > -1)
	{
		float4 colorA = Palettes.Sample(PalettesSampler, float2(colorIndex, lerpA / float(nPal)));
		float4 colorB = Palettes.Sample(PalettesSampler, float2(colorIndex, lerpB / float(nPal)));
		output.xyz = lerp(colorA.xyz, colorB.xyz, lerpVal);
	}
	
	
	output.a = lerp(0.0, output.a, alpha);
	output.rgb *= output.a;
	
	return output;
}

