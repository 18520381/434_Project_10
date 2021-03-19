def rgbToHSV(r, g, b):
    """Convert RGB color space to HSV color space
    
    @param r: Red
    @param g: Green
    @param b: Blue
    return (h, s, v)  
    """
    maxc = max(r, g, b)
    minc = min(r, g, b)
    colorMap = {
        id(r): 'r',
        id(g): 'g',
        id(b): 'b'
    }
    if colorMap[id(maxc)] == colorMap[id(minc)]:
        h = 0
    elif colorMap[id(maxc)] == 'r':
        h = 60.0 * ((g - b) / (maxc - minc)) % 360.0
    elif colorMap[id(maxc)] == 'g':
        h = 60.0 * ((b - r) / (maxc - minc)) + 120.0
    elif colorMap[id(maxc)] == 'b':
        h = 60.0 * ((r - g) / (maxc - minc)) + 240.0
    v = maxc
    if maxc == 0.0:
        s = 0.0
    else:
        s = 1.0 - (minc / maxc)
    return (h, s, v)

from PIL import Image
img = Image.open('/home/iodern/CE434/Week2/test.png')
pixels = img.load()

img.show()

new_img = Image.new(img.mode, img.size)
pixels_new = new_img.load()
for i in range(new_img.size[0]):
    for j in range(new_img.size[1]):
        r, b, g = pixels[i,j]
        r, b, g = rgbToHSV(r, g, b)
        pixels_new[i,j] = (int(r), int(b), int(g), 0)
new_img.show()