struct PS_INPUT
{
  float4 Tint : COLOR0;
  float2 texCoord : TEXCOORD0;
};

struct PS_OUTPUT
{
    float4 Color   : SV_TARGET;
};

Texture2D<float4> bkd : register(t1);
sampler bkdSampler : register(s1);
Texture2D<float4> texture_img : register(t2);
sampler texture_imgSampler : register(s2);

cbuffer PS_VARIABLES : register(b0)
{
	float ox;
	float oy;
	float xcoeff;
	float ycoeff;
	float4 RGB;
	float4 SRGB; // <-- The RGB values were added by EX64 to allow for customization of the window colors.
	int ORGB; // <-- This value is an int to allow the checkbox to work correctly.
};


float4 ps_main( in PS_INPUT In ) : SV_TARGET
{

	float4 bkcol = bkd.Sample(bkdSampler,In.texCoord) * In.Tint;
	float2 txcol;

	txcol.x = In.texCoord.x+(abs(ox)*xcoeff);
	txcol.y =  In.texCoord.y+(abs(oy)*ycoeff);

	float4 imcol = texture_img.Sample(texture_imgSampler,txcol);

	if( any(bkcol.rgb != RGB.rgb)) // <-- This event checks if the color of whatever is behind the object is different then the BG color.
	{
		if (ORGB != 1) // <-- This event checks if the ORGB value is different then 1, if it is, set it to the custom color. If it equals 1, disable the code.
	{
		imcol.r*=SRGB.r;
		imcol.g*=SRGB.g;
		imcol.b*=SRGB.b;
	}

	if (ORGB != 0) // <-- Same happens here. It checks if ORGB is different then 0, if it is, set it to the orignial shader colors. If it isn't, disable the code, allowing the custom color to be used.
	{
		imcol.r*=0.09;
		imcol.g*=0.06;
		imcol.b*=1.1;
	}

	}

	return imcol; // <-- This event set's the image colors to the shadow color, creating that cutout effect.

	}

