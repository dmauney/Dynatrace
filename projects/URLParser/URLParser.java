import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.NameValuePair;

import java.net.URLDecoder;
import java.net.URI;
import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Collections;

import org.apache.commons.codec.net.URLCodec;

public class URLParser {
    static List<String>  whitelist = new ArrayList<String>();
	
    public static void main(String[] args) throws Exception {
        
        if (args.length != 1) {
            System.err.println(
                "Usage: java URLParser <URL>");
            System.exit(1);
        }

		// Initialize the whitelist
		whitelist.add("src");
		whitelist.add("obj");
		whitelist.add("swatch");
	    
        String url = args[0];
		
		//url = "http://neimanmarcus.scene7.com/ir/render/NeimanMarcusRender/NMT9LXL_m_01?obj=base_color&src=NMT9LXL_01&resmode=sharp2&sharpen=1&qlt=85,1&wid=400&height=500";

		// AMP is bad... url = "http://neimanmarcus.scene7.com/ir/render/NeimanMarcusRender/NMT9LXL_m_01?obj=base_color%26amp%3Bsrc%3DNMT9LXL_01%26amp%3Bresmode%3Dsharp2%26amp%3Bsharpen%3D1%26amp%3Bqlt%3D85%2C1%26amp%3Bwid%3D400%26amp%3Bheight%3D500%3Bhttp%3A%2F%2Fwww.neimanmarcus.com%2FWomens-Clothing%2FTops%2Fcat42960827_cat17740747_cat000001%2Fc.cat%23userConstrainedResults%3Dtrue%26amp%3Brefinements%3D%26amp%3Bpage%3D3%26amp%3BpageSize%3D120%26amp%3Bsort%3DPCS_SORT%26amp%3BdefinitionPath%3D%2Fnm%2Fcommerce%2Fpagedef_rwd%2Ftemplate%2FEndecaDrivenHome%26amp%3BlocationInput%3D%26amp%3BradiusInput%3D100%26amp%3BonlineOnly%3D%26amp%3BallStoresInput%3Dfalse%26amp%3Brwd%3Dtrue%26amp%3BcatalogId%3Dcat42960827%22%20count%3D%221%22";
		
		//url = "http://neimanmarcus.scene7.com/ir/render/NeimanMarcusRender/NMT9P96_m_34";

		//String decoded_url = URLDecoder.decode(url, "UTF-8");
		
        URI uri = new URI(url);
		
        //String decodedURIString = uri.getPath()+"?"+uri.getQuery();
        //String decodedURIString = new URLCodec().decode(url);
		
		//System.out.println(decodedURIString);
		
		//URI decodedURI = new URI(decodedURIString);

		List list = URLEncodedUtils.parse(uri, "UTF-8");
		
		String path = uri.getPath();
		String pathLastNode = path.substring(path.lastIndexOf("/")+1);
		
		System.out.print(pathLastNode);

		displayFromList(list);
		
		System.out.print("|List: " + list);

		System.out.println("");
    }
	
    private static void displayFromList(List list) {
        List  results = new ArrayList();

		Iterator<NameValuePair> iterator = list.iterator();
		while (iterator.hasNext()) {
		    NameValuePair nvp = iterator.next();
			String name = nvp.getName();
			String value = nvp.getValue();
			if (whitelist.contains(name) || value.contains("style") || value.contains("imprint")) {
				results.add(name+"="+value);
			}
		}

        Collections.sort(results);
		iterator = results.iterator();
		while (iterator.hasNext()) {
		    //NameValuePair nvp = iterator.next();
			//System.out.println(nvp.getName() + "=" + nvp.getValue());
			System.out.print("|" + iterator.next());
		}
	}
}
