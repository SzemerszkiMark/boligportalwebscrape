const puppeteer = require("puppeteer");
const cheerio = require("cheerio");



let browser;
 
async function scrapeOdenseInIndexPage(url) {
try {
  const page = await browser.newPage();
  await page.goto(url);
  const html = await page.evaluate(() => document.body.innerHTML);
  const $ = await cheerio.load(html);
const homes = $("[class = 'AdCard']").map((i, element) => "https://www.boligportal.dk" +
    $(element).attr("href")).get();
    console.log(homes)
    return homes;
  } catch(err) {
      console.error(err);
  }   

}

const scraperesults = [];

async function scraperDescriptionPage(url,page) {
    try{
      await page.goto(url);
      const html = await page.evaluate(() => document.body.innerHTML);
      const $ = await cheerio.load(html);
      const Address =$("#app_placeholder > div.App.App--modalClosed > div.App__body > div.AdDetail > div.AdDetail__header > div > div > h2")
      const MånedligLeje =$("#app_placeholder > div.App.App--modalClosed > div.App__body > div.AdDetail > div.AdDetail__body > div.AdDetail__contents > div > div > div.AdDetail__contents-features > div > div:nth-child(4) > div:nth-child(3) > span.AdFeatures__item-value").text();
      const MånedligAconto =$("#app_placeholder > div.App.App--modalClosed > div.App__body > div.AdDetail > div.AdDetail__body > div.AdDetail__contents > div > div > div.AdDetail__contents-features > div > div:nth-child(4) > div:nth-child(4) > span.AdFeatures__item-value").text();
      const BoligType =$("#app_placeholder > div.App.App--modalClosed > div.App__body > div.AdDetail > div.AdDetail__body > div.AdDetail__contents > div > div > div.AdDetail__contents-features > div > div:nth-child(2) > div:nth-child(1) > span.AdFeatures__item-value").text();
      const Værelser =$("#app_placeholder > div.App.App--modalClosed > div.App__body > div.AdDetail > div.AdDetail__body > div.AdDetail__contents > div > div > div.AdDetail__contents-features > div > div:nth-child(2) > div:nth-child(3) > span.AdFeatures__item-value").text();
      const Størrelse =$("#app_placeholder > div.App.App--modalClosed > div.App__body > div.AdDetail > div.AdDetail__body > div.AdDetail__contents > div > div > div.AdDetail__contents-features > div > div:nth-child(2) > div:nth-child(2) > span.AdFeatures__item-value").text();
      const Møbleret =$("#app_placeholder > div.App.App--modalClosed > div.App__body > div.AdDetail > div.AdDetail__body > div.AdDetail__contents > div > div > div.AdDetail__contents-features > div > div:nth-child(2) > div:nth-child(5) > span.AdFeatures__item-value").text();
      const Delevenlig =$("#app_placeholder > div.App.App--modalClosed > div.App__body > div.AdDetail > div.AdDetail__body > div.AdDetail__contents > div > div > div.AdDetail__contents-features > div > div:nth-child(2) > div:nth-child(6) > span.AdFeatures__item-value").text();
      const HusdyrTilladt  =$("#app_placeholder > div.App.App--modalClosed > div.App__body > div.AdDetail > div.AdDetail__body > div.AdDetail__contents > div > div > div.AdDetail__contents-features > div > div:nth-child(2) > div:nth-child(7) > span.AdFeatures__item-value").text();
      const Lejeperiode =$("#app_placeholder > div.App.App--modalClosed > div.App__body > div.AdDetail > div.AdDetail__body > div.AdDetail__contents > div > div > div.AdDetail__contents-features > div > div:nth-child(4) > div:nth-child(1) > span.AdFeatures__item-value").text();
      const Overtagelsesdato  =$("#app_placeholder > div.App.App--modalClosed > div.App__body > div.AdDetail > div.AdDetail__body > div.AdDetail__contents > div > div > div.AdDetail__contents-features > div > div:nth-child(4) > div:nth-child(2) > span.AdFeatures__item-value").text();
      const Depositum =$("#app_placeholder > div.App.App--modalClosed > div.App__body > div.AdDetail > div.AdDetail__body > div.AdDetail__contents > div > div > div.AdDetail__contents-features > div > div:nth-child(4) > div:nth-child(5) > span.AdFeatures__item-value").text();
      const ForudbetaltLeje =$("#page-property-presentation > div.container-wrap--secondary > div > div > div:nth-child(2) > div > div > table > tbody > tr:nth-child(3) > td:nth-child(2)").text();
      const Oprettelsesdato  =$("#app_placeholder > div.App.App--modalClosed > div.App__body > div.AdDetail > div.AdDetail__body > div.AdDetail__contents > div > div > div.AdDetail__contents-features > div > div:nth-child(4) > div:nth-child(8) > span.AdFeatures__item-value").text();
      const scraperesult = {url, Address, MånedligLeje, MånedligAconto, BoligType, Værelser, Størrelse, Møbleret, Delevenlig, HusdyrTilladt, Lejeperiode, Overtagelsesdato, Depositum, ForudbetaltLeje, Oprettelsesdato, };
      scraperesults.push(scraperesult);
      console.log(scraperesults)
      return(scraperesults);
    } catch (err) {
      console.error(err);  
    }  
}




async function main() {
    browser = await puppeteer.launch({ headless: false });
    const descriptionPage = await browser.newPage();
    const homes = await scrapeOdenseInIndexPage(
        "https://www.boligportal.dk/find?placeIds=71&startRecord=1" 
      );
      for( var i = 0; i <= homes.length; i++) {
      await scraperDescriptionPage( homes[i], descriptionPage, );
      
    }
      
      
}
main();
