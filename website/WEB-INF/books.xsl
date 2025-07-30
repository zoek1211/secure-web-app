<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <!-- Declare a parameter for the context path -->
    <xsl:param name="contextPath" select="'/'" />

    <!-- Define a key to group books by category attribute -->
    <xsl:key name="booksByCategory" match="book" use="@category" />

    <xsl:output method="html" indent="yes" encoding="UTF-8"/>

    <!-- Template matching the root element -->
    <xsl:template match="/books">
      <html>
        <head>
          <title>All Books by Category</title>
          <style>
            body { font-family: Arial, sans-serif; margin: 20px; }
            h1.title { font-size: 20px; color: #333; margin-bottom: 20px; }
            .category { margin-bottom: 40px; }
            .category-header {
              display: flex;
              justify-content: space-between;
              align-items: center;
              margin-bottom: 10px;
            }
            .category-header .category-name {
              font-size: 18px;
              font-weight: bold;
              color: #333;
            }
            .category-header .view-genre {
              font-size: 14px;
              color: #007bff;
            }
            .books { display: flex; gap: 20px; }
            .book { width: 150px; }
            .book .cover img { 
                width: 100px; 
                height: auto; 
                display: block; 
                margin: 0 0 10px 0; 
            }
            .book .title { font-weight: bold; margin-bottom: 5px; }
            
            .book .isbn, .book .quantity, .book .holds, .author, .year {
                font-size: 12px;
                color: #444;
                margin-bottom: 3px;
            }
          </style>
        </head>
        <body>
          <h1 class="title">All Books by Category</h1>
          <!-- Muenchian grouping: iterate over each distinct category -->
          <xsl:for-each select="book[generate-id() = generate-id(key('booksByCategory', @category)[1])]">
            <div class="category">
              <div class="category-header">
                <span class="category-name"><xsl:value-of select="@category"/></span>
                <span class="view-genre">View Genre &#x2192;</span>
              </div>
              <div class="books">
                <!-- For each book in this category -->
                <xsl:for-each select="key('booksByCategory', @category)">
                  <div class="book">
                    <div class="cover">
                      <!-- <img src="{$contextPath}/SecureImage?name={cover}" alt="{title} Cover"> -->
					  <img id="cover-{position()}" data-image="{cover}" alt="{title} Cover"/>
                    </div>
                    <div class="title"><xsl:value-of select="title"/></div>
                    <div class="author"><xsl:value-of select="author"/></div>
                    <div class="year"><xsl:value-of select="year"/></div>
                    <div class="isbn">ISBN: <xsl:value-of select="isbn"/></div>
                    <div class="quantity">Qty: <xsl:value-of select="quantity"/></div>
                    <div class="holds">Holds: <xsl:value-of select="holds"/></div>
                  </div>
                </xsl:for-each>
              </div>
            </div>
          </xsl:for-each>
          
          <!-- JavaScript to Fetch and Display Base64 Images using Canvas -->
		    <script>
		        
				document.addEventListener("DOMContentLoaded", function() {
				    let images = document.querySelectorAll('img[data-image]');
				
				    images.forEach(img => {
				        let imageName = img.getAttribute('data-image');
				
				        // Ensure `contextPath` is defined properly in the JSP/XSLT
				        let contextPath = "<xsl:value-of select='$contextPath'/>";
				        let fetchUrl = contextPath + "/SecureImage?name=" + encodeURIComponent(imageName);
				
				        fetch(fetchUrl)
				            .then(response => {
				                if (!response.ok) {
				                    throw new Error(`HTTP error! Status: ${response.status}`);
				                }
				                return response.text();
				            })
				            .then(base64Data => {
				                console.log("Image loaded:", imageName); // Debugging
				                
				                // Create a new Image object
				                let imgElement = new Image();
				                imgElement.src = base64Data;
				                
				                imgElement.onload = function() {
				                    // Define max width and height 
				                    const MAX_WIDTH = 100;  // Adjust as needed
				                    const SCALE_FACTOR = MAX_WIDTH / imgElement.width;
				                    let newWidth = MAX_WIDTH;
				                    let newHeight = imgElement.height * SCALE_FACTOR;
				
				                    // Create a canvas element
				                    let canvas = document.createElement("canvas");
				                    let ctx = canvas.getContext("2d");
				
				                    // Set canvas size based on scaled image
				                    canvas.width = newWidth;
				                    canvas.height = newHeight;
				
				                    // Draw the image onto the canvas
				                    ctx.drawImage(imgElement, 0, 0, newWidth, newHeight);
				
				                    // Replace the img tag with the canvas
				                    img.replaceWith(canvas);
				                };
				            })
				            .catch(error => console.error("Error loading image:", error));
				    });
				});
				
				
		    </script>
          
        </body>
      </html>
    </xsl:template>
</xsl:stylesheet>
