GTEST_BUILD_DIR=thirdparty/googletest/build
GTEST_INSTALL_PREFIX=install
GTEST_INSTALL_DIR=$(GTEST_BUILD_DIR)/$(GTEST_INSTALL_PREFIX)
GTEST_INCLUDE_DIR=$(GTEST_INSTALL_DIR)/include
GTEST_LIB_DIR=$(GTEST_INSTALL_DIR)/lib

CXX_STANDARD=-std=c++14

CXXFLAGS=$(CXX_STANDARD)
CPPFLAGS=-I$(GTEST_INCLUDE_DIR)
LDFLAGS=-L$(GTEST_LIB_DIR)
LIBS=-lgtest -lgtest_main -lpthread

.PHONY: test

test: bin/example_test
	$<

bin/example_test: test/example.cpp $(GTEST_LIB_DIR)/libgtest.a $(GTEST_LIB_DIR)/libgtest_main.a
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) $< -o $@ $(LIBS)

$(GTEST_LIB_DIR)/libgtest.a $(GTEST_LIB_DIR)/libgtest_main.a:
	mkdir -p $(GTEST_BUILD_DIR)
	cd $(GTEST_BUILD_DIR) && \
		cmake -DCMAKE_INSTALL_PREFIX=$(GTEST_INSTALL_PREFIX) -DCMAKE_CXX_FLAGS=$(CXX_STANDARD) .. && \
		make && \
		make install
