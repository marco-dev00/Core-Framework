// Pixel shader input structure
struct PS_INPUT
{
  float4 Tint : COLOR0;
  float2 texCoord : TEXCOORD0;
  float4 Position : SV_POSITION;
};

Texture2D<float4> Tex0 : register(t0);
sampler Tex0Sampler : register(s0);

Texture2D<float4> Palettes : register(t1);
sampler PalettesSampler : register(s1);


cbuffer PS_VARIABLES:register(b0)
{
	int nPal, lerpA, lerpB;
	float lerpVal;
}


float4 Demultiply(float4 _color)
{
	float4 color = _color;
	if ( color.a != 0 )
		color.rgb /= color.a;
	return color;
}

float4 ps_main(float4 color : COLOR0, in PS_INPUT In ) : SV_TARGET
{
	float4 output =  Tex0.Sample(Tex0Sampler, In.texCoord);
	float colorIndex = -1;

	[unroll]for(int i=0;i<256 && output.a > 0.0;i++)
	{
		float4 OriginalPalette = Palettes.Sample(PalettesSampler, float2(i/256.0,0.0));
		if(OriginalPalette.a = 0.0)
		{
			break;
		}
		else
		{
			if( distance(output.rgb, OriginalPalette.rgb) == 0 )
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
		output.rgb = lerp(colorA.rgb, colorB.rgb, lerpVal);
	}
	
	output *= In.Tint;

	return output;
}


float4 ps_main_pm(float4 color : COLOR0, in PS_INPUT In ) : SV_TARGET
{
	float4 output =  Demultiply(Tex0.Sample(Tex0Sampler, In.texCoord));
	float colorIndex = -1;

	[unroll]for(int i=0;i<256 && output.a > 0.0;i++)
	{
		float4 OriginalPalette = Demultiply(Palettes.Sample(PalettesSampler, float2(i/256.0,0.0)));
		if(OriginalPalette.a = 0.0)
		{
			break;
		}
		else
		{
			if( distance(output.rgb, OriginalPalette.rgb) == 0 )
				{
					colorIndex = i/256.0;
					break;
				}
		}
	}

	if(colorIndex > -1)
	{
		float4 colorA = Demultiply(Palettes.Sample(PalettesSampler, float2(colorIndex, lerpA / float(nPal))));
		float4 colorB = Demultiply(Palettes.Sample(PalettesSampler, float2(colorIndex, lerpB / float(nPal))));
		output.rgb = lerp(colorA.rgb, colorB.rgb, lerpVal);
	}
	
	output.rgb *= output.a;	
	output *= In.Tint;

	return output;
}

