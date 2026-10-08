# :computer: EXIF-Meta-Batch

</br>

![Compiler](https://github.com/user-attachments/assets/a916143d-3f1b-4e1f-b1e0-1067ef9e0401) <img src="https://github.com/user-attachments/assets/b3b8110c-3598-459f-8e25-313251ff0803" />  
![Components](https://github.com/user-attachments/assets/d6a7a7a4-f10e-4df1-9c4f-b4a1a8db7f0e) <img src="https://github.com/user-attachments/assets/91feb592-abf9-4708-812c-af46dc92307e" /> <img src="https://github.com/user-attachments/assets/8deeb66e-ca8c-4164-91c6-1a59ef611eaf" /> <img src="https://github.com/user-attachments/assets/05340d9d-340c-43c4-8ca1-73d770cfa27f" />  
![Description](https://github.com/user-attachments/assets/dbf330e0-633c-4b31-a0ef-b1edb9ed5aa7) <img src="https://github.com/user-attachments/assets/cd66c697-219d-4a3b-ac9b-e77caaa4ed5d" />  
![Last Update](https://github.com/user-attachments/assets/e1d05f21-2a01-4ecf-94f3-b7bdff4d44dd) <img src="https://github.com/user-attachments/assets/1e64ccf2-e8fb-4995-ad60-ea2f07324ebf" />  
![License](https://github.com/user-attachments/assets/ff71a38b-8813-4a79-8774-09a2f3893b48) ![Freeware](https://github.com/user-attachments/assets/1fea2bbf-b296-4152-badd-e1cdae115c43)  

</br>



Exchangeable image file format (officially Exif, according to JEIDA/JEITA/CIPA specifications) is a standard that specifies formats for images, sound, and ancillary tags used by digital cameras (including smartphones), scanners and other systems handling image and sound files recorded by [digital cameras](https://en.wikipedia.org/wiki/Digital_camera). The specification uses the following existing encoding formats with the addition of specific [metadata](https://en.wikipedia.org/wiki/Metadata) tags: JPEG lossy coding for compressed image files, [TIFF](https://en.wikipedia.org/wiki/TIFF) Rev. 6.0 ([RGB](https://en.wikipedia.org/wiki/RGB_color_model) or [YCbCr](https://en.wikipedia.org/wiki/YCbCr)) for uncompressed image files, and [RIFF](https://en.wikipedia.org/wiki/Resource_Interchange_File_Format) WAV for audio files (linear PCM or ITU-T [G.711](https://en.wikipedia.org/wiki/G.711) μ-law [PCM](https://en.wikipedia.org/wiki/Pulse-code_modulation) for uncompressed audio data, and IMA-ADPCM for compressed audio data). It does not support JPEG 2000 or GIF encoded images. This standard consists of the Exif image file specification and the Exif audio file specification.

<br>

<img src="https://github.com/user-attachments/assets/79b84741-d3d5-40d3-8813-3881ad83e0d1" />

<br>
<br>

Import formats : jpeg; jpg; jfif;

The Exif tag structure is borrowed from TIFF files. On several image specific properties, there is a large overlap between the tags defined in the TIFF, Exif, TIFF/EP, and DCF standards. For descriptive metadata, there is an overlap between Exif, [IPTC](https://en.wikipedia.org/wiki/IPTC_Information_Interchange_Model) Information Interchange Model and [XMP](https://en.wikipedia.org/wiki/Extensible_Metadata_Platform) info, which also can be embedded in a JPEG file. The [Metadata Working Group](https://en.wikipedia.org/wiki/Metadata_Working_Group) has guidelines on mapping tags between these standards.

<br>

# :wrench: Meta access
| Key | HEX | Type | Tag description |
| :----------- | :----------- | :----------- | :----------- |
| Description     | $010E     | ASCII | A character string giving the title of the image. It may be a comment such as "1988 company picnic" or the like. Two-bytes character codes cannot be used. When a 2-bytes code is necessary, the Exif Private tag <UserComment> is to be used.     |
| Maker     | $010F     | ASCII | The manufacturer of the recording equipment. This is the manufacturer of the DSC, scanner, video digitizer or other equipment that generated the image. When the field is left blank, it is treated as unknown.     |
| Model     | $0110     | ASCII     | The model name or model number of the equipment. This is the model name or number of the DSC, scanner, video digitizer or other equipment that generated the image. When the field is left blank, it is treated as unknown.     |
| Date     | $0132     | ASCII     | The date and time of image creation. In Exif standard, it is the date and time the file was changed.     |
| Speed     | $829A     | Rational     | Exposure time, given in seconds.     |
| Aperture     | $829D     | Rational     | The F number.     |
| ExpoProgram     | $8822     | Short     | The class of the program used by the camera to set exposure when the picture is taken.     |
| Iso     | $8827     | Short     | Indicates the ISO Speed and ISO Latitude of the camera or input device as specified in ISO 12232.     |
| OriginalDate     | $9003     | ASCII     | The date and time when the original image data was generated.     |
| MeteringMode     | $9207     | Short     | The metering mode.     |
| Focal     | $920A     | Rational     | The actual focal length of the lens, in mm.     |
| ImageWidth     | $A002     | Long     | Information specific to compressed data. When a compressed file is recorded, the valid width of the meaningful image must be recorded in this tag, whether or not there is padding data or a restart marker. This tag should not exist in an uncompressed file.     |
| ImageHeight     | $A003     | Long     | Information specific to compressed data. When a compressed file is recorded, the valid height of the meaningful image must be recorded in this tag, whether or not there is padding data or a restart marker. This tag should not exist in an uncompressed file. Since data padding is unnecessary in the vertical direction, the number of lines recorded in this valid image height tag will in fact be the same as that recorded in the SOF.     |
| WhiteBalance     | $A403     | Short     | This tag indicates the white balance mode set when the image was shot.     |
| Focal35mm     | $A405     | Short     | This tag indicates the equivalent focal length assuming a 35mm film camera, in mm. A value of 0 means the focal length is unknown. Note that this tag differs from the <FocalLength> tag.     |
| Contrast     | $A408     | Short     | This tag indicates the direction of contrast processing applied by the camera when the image was shot.     |
| Saturation     | $A409     | Short     | This tag indicates the direction of saturation processing applied by the camera when the image was shot.     |
| Sharpness     | $A40A     | Short     | This tag indicates the direction of sharpness processing applied by the camera when the image was shot.     |
| Copyright     | $8298     | ASCII     | Copyright information. In this standard the tag is used to indicate both the photographer and editor copyrights. It is the copyright notice of the person or organization claiming rights to the image. The Interoperability copyright statement including date and rights should be written in this field; e.g., "Copyright, John Smith, 19xx. All rights reserved.". In this standard the field records both the photographer and editor copyrights, with each recorded in a separate part of the statement. When there is a clear distinction between the photographer and editor copyrights, these are to be written in the order of photographer followed by editor copyright, separated by NULL (in this case since the statement also ends with a NULL, there are two NULL codes). When only the photographer copyright is given, it is terminated by one NULL code. When only the editor copyright is given, the photographer copyright part consists of one space followed by a terminating NULL code, then the editor copyright is given. When the field is left blank, it is treated as unknown.     |
| UserComment1     | $9286     | ASCII     | A tag for Exif users to write keywords or comments on the image besides those in <ImageDescription>, and without the character code limitations of the <ImageDescription> tag.     |
| Artist     | $013B     | ASCII     | This tag records the name of the camera owner, photographer or image creator. The detailed format is not specified, but it is recommended that the information be written as in the example below for ease of Interoperability. When the field is left blank, it is treated as unknown. Ex.) "Camera owner, John Smith; Photographer, Michael Brown; Image creator, Ken James"     |
| ExifVersion     | $9000     | Undefined     | The version of this standard supported. Nonexistence of this field is taken to mean nonconformance to the standard.     |
| LensMake     | $A433     | ASCII     | This tag records the lens manufactor as an ASCII string.     |
| Software     | $0131     | ASCII     | This tag records the name and version of the software or firmware of the camera or image input device used to generate the image. The detailed format is not specified, but it is recommended that the example shown below be followed. When the field is left blank, it is treated as unknown.     |



