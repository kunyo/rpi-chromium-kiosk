.PHONY: clean test run

_appname=rpi-chromium-kiosk
_version=0.1.0
_arch=all

default:
	@echo "Please choose one of the following target: clean, dist, deb"
	@exit 2

clean:
	rm -rf ./build
	rm -rf ./dist

dist: clean
	mkdir -p ./dist/$(_appname)-$(_version)
	cp ./LICENSE.txt  ./dist/$(_appname)-$(_version)
	cp ./README.md  ./dist/$(_appname)-$(_version)
	cp ./$(_appname).service ./dist/$(_appname)-$(_version)
	cd ./dist && tar cvfz ./$(_appname)-$(_version).tar.gz $(_appname)-$(_version)

deb: dist
	mkdir -p ./build/
	tar -C ./build -xvzf ./dist/$(_appname)-$(_version).tar.gz
	cp ./dist/$(_appname)-$(_version).tar.gz ./build
	cd ./build/$(_appname)-$(_version) && debmake
	cp -r ./debian/* ./build/$(_appname)-$(_version)/debian
	chmod +x ./build/$(_appname)-$(_version)/debian/postinst
	chmod +x ./build/$(_appname)-$(_version)/debian/prerm
	chmod +x ./build/$(_appname)-$(_version)/debian/postrm
	cd ./build/$(_appname)-$(_version) && debuild -us -uc
	@echo "Package created to `realpath ./build/$(_appname)_$(_version)-1_$(_arch).deb`"